"use client";

import React from "react";
import { motion } from "framer-motion";
import Link from "next/link";
import { cn } from "@/lib/utils";

const categories = [
    { name: 'Placas Gráficas', slug: 'placas-graficas' },
    { name: 'Processadores', slug: 'processadores' },
    { name: 'Motherboards', slug: 'motherboards' },
    { name: 'Memória RAM', slug: 'memoria-ram' },
    { name: 'Armazenamento', slug: 'armazenamento' },
    { name: 'Fontes de Alimentação', slug: 'fontes-de-alimentacao' },
    { name: 'Caixas', slug: 'caixas' },
];

const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
        opacity: 1,
        transition: {
            staggerChildren: 0.1,
            delayChildren: 0.5,
        },
    },
};

const itemVariants = {
    hidden: { y: 20, opacity: 0 },
    visible: {
        y: 0,
        opacity: 1,
        transition: { type: "spring", stiffness: 100 },
    },
};

export default function HomePage() {
    return (
        <div className="relative w-full min-h-screen overflow-hidden flex flex-col items-center justify-center p-8 pt-32">
            {/* Aurora Background */}
            <div className="absolute top-0 left-0 w-full h-full bg-background -z-10" />
            <div className="absolute -top-1/2 -left-1/4 w-[150%] h-[150%] bg-gradient-to-r from-primary/10 via-transparent to-transparent animate-[spin_20s_linear_infinite] -z-10" />
            <div className="absolute -bottom-1/2 -right-1/4 w-[150%] h-[150%] bg-gradient-to-l from-primary/10 via-transparent to-transparent animate-[spin_25s_linear_infinite_reverse] -z-10" />
            
            <motion.div
                initial={{ opacity: 0, y: -20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.2 }}
                className="text-center mb-16"
            >
                <h1 className="text-6xl md:text-8xl font-bold tracking-tighter bg-clip-text text-transparent bg-gradient-to-b from-foreground to-gray-400">
                    Cinematic Portal
                </h1>
                <p className="mt-4 text-xl text-muted-foreground">Explore our premium components.</p>
            </motion.div>

            <motion.div 
                variants={containerVariants}
                initial="hidden"
                animate="visible"
                className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 w-full max-w-7xl"
            >
                {categories.map((category, index) => (
                    <motion.div key={category.slug} variants={itemVariants} layout className={cn(index === 0 && 'lg:col-span-2 lg:row-span-2')}>
                        <Link href={`/categoria/${category.slug}`}>
                            <motion.div
                                whileHover={{ scale: 1.03, boxShadow: "0px 0px 30px hsl(var(--primary) / 0.3)" }}
                                transition={{ type: "spring", stiffness: 300 }}
                                className="relative w-full h-full min-h-[200px] p-6 rounded-2xl bg-black/20 border border-border backdrop-blur-sm flex items-end justify-start cursor-pointer overflow-hidden"
                            >
                                <h2 className="text-2xl font-semibold text-foreground z-10">{category.name}</h2>
                            </motion.div>
                        </Link>
                    </motion.div>
                ))}
            </motion.div>
        </div>
    );
}
