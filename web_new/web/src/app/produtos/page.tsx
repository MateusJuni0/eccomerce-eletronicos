import { ProductCard } from '@/components/ProductCard';
import { supabase } from '@/lib/supabase';

// Use ISR revalidation
export const revalidate = 60;

const ProductsPage = async () => {
  const { data: products, error } = await supabase
    .from('products')
    .select('*')
    .limit(100);

  if (error) {
    console.error("Supabase Error:", error);
  }

  return (
    <div className={`min-h-screen bg-[#020617] pt-32 p-8`}>
      <div className="max-w-7xl mx-auto">
        <h1
          className={`text-5xl md:text-7xl font-black mb-4 text-center tracking-tighter text-transparent bg-clip-text bg-gradient-to-br from-white to-cyan-500`}
        >
          Todo o Catálogo Premium
        </h1>
        <p className="text-gray-400 text-center mb-16 max-w-2xl mx-auto text-lg">
          Explore a nossa seleção completa de hardware de elite. Componentes rigorosamente selecionados para a máxima performance.
        </p>

        {(!products || products.length === 0) && (
          <p className="text-white text-center text-xl border border-white/5 rounded-2xl bg-white/5 py-12 backdrop-blur-sm">Nenhum produto encontrado no catálogo.</p>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          {products?.map((product, index) => {
            // Price is stored in cents
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
                images={[imageUrl, imageUrl, imageUrl]} // Duplicate for slideshow
                price={priceFormatted}
              />
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default ProductsPage;