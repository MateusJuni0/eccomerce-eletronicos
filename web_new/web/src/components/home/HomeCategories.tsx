"use client";

import { motion } from "framer-motion";
import Link from "next/link";
import { Cpu, Server, Box, HardDrive, BatteryCharging } from "lucide-react";

const categories = [
  { name: 'Placas Gráficas', slug: 'placas-graficas', colSpan: 'md:col-span-2', rowSpan: 'md:row-span-2', icon: Cpu, desc: 'Poder computacional puro para AI e Gaming.', img: 'url(https://images.unsplash.com/photo-1591488320449-011701bb6704?auto=format&fit=crop&w=800)' },
  { name: 'Processadores', slug: 'processadores', colSpan: 'md:col-span-1', rowSpan: 'md:row-span-1', icon: Server, desc: 'Cérebros de alta frequência.', img: 'url(https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?auto=format&fit=crop&w=800)' },
  { name: 'Motherboards', slug: 'motherboards', colSpan: 'md:col-span-1', rowSpan: 'md:row-span-1', icon: Box, desc: 'A base digital.', img: 'url(https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800)' },
  { name: 'Memória RAM', slug: 'memoria-ram', colSpan: 'md:col-span-1', rowSpan: 'md:row-span-1', icon: Cpu, desc: 'Velocidade extrema.', img: 'url(https://images.unsplash.com/photo-1562976540-1502c2145186?auto=format&fit=crop&w=800)' },
  { name: 'Fontes Aliment.', slug: 'fontes-de-alimentacao', colSpan: 'md:col-span-1', rowSpan: 'md:row-span-1', icon: BatteryCharging, desc: 'Energia estável.', img: 'url(https://images.unsplash.com/photo-1587202372634-32705e3bf49c?auto=format&fit=crop&w=800)' },
  { name: 'Caixas', slug: 'caixas', colSpan: 'md:col-span-2', rowSpan: 'md:row-span-1', icon: Box, desc: 'Gabinetes com airflow ótimo.', img: 'url(https://images.unsplash.com/photo-1587202372775-e229f172b9d7?auto=format&fit=crop&w=800)' },
  { name: 'Armazenamento', slug: 'armazenamento', colSpan: 'md:col-span-2', rowSpan: 'md:row-span-1', icon: HardDrive, desc: 'Discos NVMe PCIe 5.0 para loading.', img: 'url(https://images.unsplash.com/photo-1531492746076-161ca9bcad58?auto=format&fit=crop&w=800)' },
];

export const HomeCategories = () => {
  return (
    <section id="categorias" className="py-32 bg-[#020617] relative overflow-hidden">
      {/* Background ambient lighting */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-cyan-900/10 rounded-full blur-[150px] pointer-events-none" />

      <div className="max-w-7xl mx-auto px-6 relative z-10">
        <div className="mb-16">
          <h2 className="text-4xl md:text-6xl font-black text-transparent bg-clip-text bg-gradient-to-r from-white to-gray-500 tracking-tighter">
            A Coleção Premium
          </h2>
          <p className="text-gray-400 mt-4 text-lg">Hardware selecionado meticulosamente para a elite.</p>
        </div>

        {/* BENTO GRID LAYOUT */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 auto-rows-[220px]">
          {categories.map((category, index) => (
            <Link 
              key={category.slug} 
              href={`/categoria/${category.slug}`}
              className={`group relative overflow-hidden rounded-3xl border border-white/10 bg-white/[0.02] hover:bg-white/[0.04] transition-colors duration-500 ${category.colSpan} ${category.rowSpan}`}
            >
              <motion.div
                initial={{ opacity: 0, scale: 0.95 }}
                whileInView={{ opacity: 1, scale: 1 }}
                viewport={{ once: true, margin: "-50px" }}
                transition={{ duration: 0.5, delay: index * 0.1 }}
                className="w-full h-full flex flex-col justify-end p-8 relative z-10"
              >
                {/* Background Image handling for Bento Cards */}
                {category.img !== 'none' && (
                  <div 
                    className="absolute inset-0 z-0 opacity-20 group-hover:opacity-40 transition-opacity duration-700 mix-blend-overlay bg-cover bg-center group-hover:scale-105"
                    style={{ backgroundImage: category.img }}
                  />
                )}
                
                <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent z-0" />
                
                <div className="relative z-10 transform group-hover:-translate-y-2 transition-transform duration-500">
                  <div className="p-3 bg-white/10 backdrop-blur-md rounded-2xl text-cyan-400 inline-block mb-4 border border-white/5 shadow-xl group-hover:scale-110 transition-transform duration-500">
                    <category.icon className="w-6 h-6" />
                  </div>
                  <h3 className="text-2xl md:text-3xl font-bold text-white tracking-tight mb-2">
                    {category.name}
                  </h3>
                  <p className="text-gray-300/80 leading-relaxed font-light line-clamp-2">
                    {category.desc}
                  </p>
                </div>
                
                {/* Corner Arrow */}
                <div className="absolute top-6 right-6 w-10 h-10 rounded-full bg-white/5 border border-white/10 flex items-center justify-center opacity-0 -translate-x-4 group-hover:opacity-100 group-hover:translate-x-0 transition-all duration-500 z-10">
                  <span className="text-cyan-400">→</span>
                </div>
              </motion.div>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
};