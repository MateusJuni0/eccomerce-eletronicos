"use client";

import { motion } from "framer-motion";
import { ArrowRight, Cpu, Shield, Zap } from "lucide-react";
import Link from "next/link";

export const HomeHero = () => {
  return (
    <section className="relative min-h-[90vh] flex flex-col justify-center items-center overflow-hidden bg-[#020617] pt-24">
      {/* Background Deep Glows */}
      <div className="absolute top-1/4 left-1/4 w-[600px] h-[600px] bg-cyan-900/30 rounded-full blur-[120px] pointer-events-none" />
      <div className="absolute bottom-1/4 right-1/4 w-[600px] h-[600px] bg-blue-900/20 rounded-full blur-[120px] pointer-events-none" />
      <div className="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=2070&auto=format&fit=crop')] bg-cover bg-center opacity-10 mix-blend-overlay pointer-events-none" />

      <div className="relative z-10 max-w-7xl mx-auto px-6 text-center flex flex-col items-center">
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, ease: "easeOut" }}
          className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/5 border border-white/10 mb-8 backdrop-blur-md"
        >
          <span className="flex h-2 w-2 rounded-full bg-cyan-400 animate-pulse" />
          <span className="text-sm font-medium text-cyan-50">O Próximo Nível do Hardware</span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.1, ease: "easeOut" }}
          className="text-5xl md:text-7xl lg:text-8xl font-black tracking-tighter text-transparent bg-clip-text bg-gradient-to-br from-white via-gray-300 to-gray-600 max-w-5xl leading-[1.1]"
        >
          Componentes de <br /> Alta Performance.
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.2, ease: "easeOut" }}
          className="mt-8 text-xl md:text-2xl text-gray-400 max-w-2xl font-light"
        >
          Workstations e setups gaming premium. Descobre o hardware que impulsiona o futuro do Deep Learning, 3D e Gaming Ultra.
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.3, ease: "easeOut" }}
          className="mt-12 flex flex-col sm:flex-row gap-4"
        >
          <Link href="#categorias" className="group flex items-center gap-2 px-8 py-4 bg-cyan-500 hover:bg-cyan-400 text-black font-bold rounded-full transition-all duration-300 hover:scale-105 hover:shadow-[0_0_40px_rgba(34,211,238,0.4)]">
            Explorar Loja <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </Link>
          <Link href="#destaques" className="px-8 py-4 bg-white/5 hover:bg-white/10 text-white font-medium rounded-full border border-white/10 backdrop-blur-md transition-all duration-300 hover:scale-105">
            Ver Destaques
          </Link>
        </motion.div>

        {/* Feature Highlights */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 1, delay: 0.8 }}
          className="mt-24 grid grid-cols-1 sm:grid-cols-3 gap-8 border-t border-white/10 pt-12 w-full max-w-4xl"
        >
          {[
            { icon: Zap, title: "Performance Extrema", desc: "Hardware testado para 4K e AI" },
            { icon: Shield, title: "Garantia Premium", desc: "3 anos de proteção total" },
            { icon: Cpu, title: "Stock Garantido", desc: "Envio em 24h para Portugal" }
          ].map((feature, i) => (
            <div key={i} className="flex flex-col items-center text-center">
              <div className="p-3 rounded-2xl bg-white/5 border border-white/10 mb-4 text-cyan-400">
                <feature.icon className="w-6 h-6" />
              </div>
              <h3 className="text-white font-semibold text-lg">{feature.title}</h3>
              <p className="text-gray-400 text-sm mt-1">{feature.desc}</p>
            </div>
          ))}
        </motion.div>
      </div>
    </section>
  );
};