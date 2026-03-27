"use client";

import { motion } from "framer-motion";
import Link from "next/link";
import { ProductCard } from "@/components/ProductCard";

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export const HomeFeatured = ({ products }: { products: any[] }) => {
  return (
    <section id="destaques" className="py-32 bg-[#020617] relative overflow-hidden">
      <div className="absolute top-1/4 right-0 w-[500px] h-[500px] bg-purple-900/10 rounded-full blur-[150px] pointer-events-none" />

      <div className="max-w-7xl mx-auto px-6 relative z-10">
        <div className="text-center mb-24">
          <motion.h2 
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-4xl md:text-6xl font-black text-transparent bg-clip-text bg-gradient-to-br from-white to-gray-600 tracking-tighter"
          >
            Destaques da Semana
          </motion.h2>
          <motion.p 
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="text-gray-400 mt-6 text-xl max-w-2xl mx-auto"
          >
            As peças mais procuradas pelos entusiastas de performance e criadores de conteúdo.
          </motion.p>
        </div>

        {products && products.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {products.map((product, index) => {
              const priceVal = product.price_cents ? product.price_cents / 100 : 0;
              const priceFormatted = new Intl.NumberFormat('pt-PT', { style: 'currency', currency: 'EUR' }).format(priceVal);
              let imageUrl = product.platform_metadata?.image_url;
              if (!imageUrl || imageUrl.includes('1_gqsh-5x.jpg.png') || imageUrl.includes('info-computer')) {
                  // Fallbacks baseados na string
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
                <motion.div 
                  key={product.id || index}
                  initial={{ opacity: 0, y: 30 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true, margin: "-100px" }}
                  transition={{ delay: index * 0.1, duration: 0.5 }}
                >
                  <ProductCard
                    name={product.name}
                    images={[imageUrl, imageUrl, imageUrl]} // fallback
                    price={priceFormatted}
                  />
                </motion.div>
              );
            })}
          </div>
        ) : (
          <div className="text-center text-gray-500 py-12 border border-white/5 rounded-2xl bg-white/5 backdrop-blur-sm">
            Nenhum produto em destaque no momento.
          </div>
        )}

        <div className="mt-16 flex justify-center">
          <Link href="/produtos">
            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              className="px-8 py-4 bg-transparent border border-cyan-500/50 text-cyan-400 font-medium rounded-full hover:bg-cyan-500/10 transition-colors flex items-center gap-2 group"
            >
              Ver Todos os Produtos
              <span className="group-hover:translate-x-1 transition-transform">→</span>
            </motion.button>
          </Link>
        </div>
      </div>
    </section>
  );
};