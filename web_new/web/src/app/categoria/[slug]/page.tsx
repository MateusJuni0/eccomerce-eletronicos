import { ProductCard } from '@/components/ProductCard';
import { supabase } from '@/lib/supabase';

type CategoryPageProps = {
  params: {
    slug: string;
  };
};

const nicheThemes: Record<string, { gradient: string; title: string; textColor: string }> = {
  'placas-graficas': {
    gradient: 'from-green-900 via-emerald-950 to-black',
    title: 'Placas Gráficas de Elite',
    textColor: 'text-green-400'
  },
  'processadores': {
    gradient: 'from-blue-900 via-indigo-950 to-black',
    title: 'Processadores Cyber-Core',
    textColor: 'text-blue-400'
  },
  'motherboards': {
    gradient: 'from-gray-800 via-gray-950 to-black',
    title: 'Motherboards: A Base de Tudo',
    textColor: 'text-gray-300'
  },
  'memoria-ram': {
    gradient: 'from-purple-900 via-violet-950 to-black',
    title: 'Memória RAM Ultra-Rápida',
    textColor: 'text-purple-400'
  },
  'armazenamento': {
    gradient: 'from-yellow-900 via-amber-950 to-black',
    title: 'Armazenamento de Alta Velocidade',
    textColor: 'text-yellow-400'
  },
  'fontes-de-alimentacao': {
    gradient: 'from-orange-900 via-red-950 to-black',
    title: 'Fontes de Alimentação Confiáveis',
    textColor: 'text-orange-400'
  },
  'caixas': {
    gradient: 'from-slate-800 via-slate-900 to-black',
    title: 'Caixas com Design Premium',
    textColor: 'text-slate-300'
  },
};

// Use ISR revalidation
export const revalidate = 60;

const CategoryPage = async ({ params }: CategoryPageProps) => {
  const { slug } = params;
  const theme = nicheThemes[slug] || {
    gradient: 'from-gray-900 to-black',
    title: 'Categoria Não Encontrada',
    textColor: 'text-white'
  };

  // Fetch real data from the self-hosted Supabase VPS.
  // The scraped data is stored in the 'products' table.
  // We'll search for the category string in the name or description using ilike since there isn't a strict 'category' column yet.
  let searchTerms = [slug.replace('-', ' ')];
  if (slug === 'placas-graficas') searchTerms = ['tarjeta gr', 'placa gr', 'rtx', 'gtx', 'radeon', 'geforce', 'msi', 'asus', 'gigabyte'];
  if (slug === 'processadores') searchTerms = ['procesador', 'processador', 'intel', 'amd', 'ryzen', 'core i'];
  if (slug === 'motherboards') searchTerms = ['placa base', 'placa-mãe', 'motherboard', 'z790', 'b760', 'x670', 'b650', 'asus rog', 'msi mag'];
  if (slug === 'memoria-ram') searchTerms = ['memoria', 'ram', 'ddr4', 'ddr5', 'fury', 'vengeance'];
  if (slug === 'armazenamento') searchTerms = ['ssd', 'hdd', 'disco', 'nvme', 'pcie', 'kingston'];
  if (slug === 'fontes-de-alimentacao') searchTerms = ['fuente', 'fonte', 'alimentacion', 'alimentacao', 'atx', 'corsair', 'seasonic', 'power'];
  if (slug === 'caixas') searchTerms = ['caixa', 'caja', 'torre', 'gabinete', 'atx', 'micro-atx', 'nox'];

  const orQuery = searchTerms.map(term => `name.ilike.%${term}%`).join(',');

  const { data: products, error } = await supabase
    .from('products')
    .select('*')
    .or(orQuery)
    .limit(20);

  if (error) {
    console.error("Supabase Error:", error);
  }

  return (
    <div className={`min-h-screen bg-gradient-to-br ${theme.gradient} pt-32 p-8`}>
      <div className="max-w-7xl mx-auto">
        <h1
          className={`text-5xl md:text-7xl font-black mb-16 text-center tracking-tighter ${theme.textColor}`}
        >
          {theme.title}
        </h1>

        {(!products || products.length === 0) && (
          <p className="text-white text-center text-xl">Nenhum produto encontrado nesta categoria no Supabase.</p>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
          {products?.map((product, index) => {
            // Price is stored in cents in the Supabase schema mapped by Python
            const priceVal = product.price_cents ? product.price_cents / 100 : 0;
            const priceFormatted = new Intl.NumberFormat('pt-PT', { style: 'currency', currency: 'EUR' }).format(priceVal);
            
            // Extract the image URL stored in platform_metadata by the python script
            let imageUrl = product.platform_metadata?.image_url;
            
            // Provide a high-quality fallback image based on product name
            if (!imageUrl || imageUrl.includes('1_gqsh-5x.jpg.png') || imageUrl.includes('info-computer')) {
                  const n = product.name.toLowerCase();
                  if (n.includes('processador')) imageUrl = 'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?auto=format&fit=crop&q=80&w=800&h=600';
                  else if (n.includes('motherboard')) imageUrl = 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=800&h=600';
                  else if (n.includes('memória') || n.includes('ram')) imageUrl = 'https://images.unsplash.com/photo-1562976540-1502c2145186?auto=format&fit=crop&q=80&w=800&h=600';
                  else if (n.includes('ssd')) imageUrl = 'https://images.unsplash.com/photo-1628557044797-f21a177c37ec?auto=format&fit=crop&q=80&w=800&h=600';
                  else if (n.includes('fonte')) imageUrl = 'https://images.unsplash.com/photo-1587202372634-32705e3bf49c?auto=format&fit=crop&q=80&w=800&h=600';
                  else if (n.includes('caixa')) imageUrl = 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&q=80&w=800&h=600';
                  else imageUrl = 'https://images.unsplash.com/photo-1591488320449-011701bb6704?auto=format&fit=crop&q=80&w=800&h=600'; // Default is GPU
            }

            return (
              <ProductCard
                key={product.id || index}
                name={product.name}
                images={[imageUrl, imageUrl, imageUrl]} // Duplicate for slideshow since we only have 1 image per product
                price={priceFormatted}
              />
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default CategoryPage;