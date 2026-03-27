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

  // Fetch real data from the self-hosted Supabase VPS
  // O schema é ecommerce, não public, let's query the specific schema by adding schema('ecommerce')
  const { data: products, error } = await supabase
    .schema('ecommerce')
    .from('products')
    .select('*')
    .eq('category', slug)
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
          <p className="text-white text-center text-xl">Nenhum produto encontrado nesta categoria.</p>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
          {products?.map((product, index) => {
            const priceFormatted = new Intl.NumberFormat('pt-PT', { style: 'currency', currency: 'EUR' }).format(product.price);
            return (
              <ProductCard
                key={product.id || index}
                name={product.title}
                images={product.images || ['https://picsum.photos/seed/placeholder/800/600']}
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