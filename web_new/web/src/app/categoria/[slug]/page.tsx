"use client";

import { motion } from 'framer-motion';
import { ProductCard } from '@/components/ProductCard';

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

const CategoryPage = ({ params }: CategoryPageProps) => {
  const { slug } = params;
  const theme = nicheThemes[slug] || {
    gradient: 'from-gray-900 to-black',
    title: 'Categoria Não Encontrada',
    textColor: 'text-white'
  };

  const mockProducts = [
    {
      name: 'GeForce RTX 4090 SUPRIM X',
      images: ['https://picsum.photos/seed/gpu1-1/800/600', 'https://picsum.photos/seed/gpu1-2/800/600', 'https://picsum.photos/seed/gpu1-3/800/600'],
      price: '2.299,99 €'
    },
    {
        name: 'Radeon RX 7900 XTX',
        images: ['https://picsum.photos/seed/gpu2-1/800/600', 'https://picsum.photos/seed/gpu2-2/800/600', 'https://picsum.photos/seed/gpu2-3/800/600'],
        price: '1.099,99 €'
    },
    {
        name: 'GeForce RTX 4080 Super',
        images: ['https://picsum.photos/seed/gpu3-1/800/600', 'https://picsum.photos/seed/gpu3-2/800/600', 'https://picsum.photos/seed/gpu3-3/800/600'],
        price: '1.299,99 €'
    }
  ];

  return (
    <div className={`min-h-screen bg-gradient-to-br ${theme.gradient} pt-32 p-8`}>
      <div className="max-w-7xl mx-auto">
        <motion.h1
          className={`text-5xl md:text-7xl font-black mb-16 text-center tracking-tighter ${theme.textColor}`}
          initial={{ opacity: 0, y: -50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.7, ease: 'easeOut' }}
        >
          {theme.title}
        </motion.h1>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
          {mockProducts.map((product, index) => (
            <ProductCard
              key={index}
              name={product.name}
              images={product.images}
              price={product.price}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

export default CategoryPage;