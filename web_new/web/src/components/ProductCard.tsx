"use client";

import { useState, useRef, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Tilt } from 'react-tilt';
import Image from 'next/image';

type ProductCardProps = {
  name: string;
  images: string[];
  price: string;
};

export const ProductCard = ({ name, images, price }: ProductCardProps) => {
  const [currentImage, setCurrentImage] = useState(0);
  const intervalRef = useRef<NodeJS.Timeout | null>(null);

  const startSlideshow = () => {
    if (intervalRef.current) clearInterval(intervalRef.current);
    intervalRef.current = setInterval(() => {
      setCurrentImage((prev) => (prev + 1) % images.length);
    }, 1200);
  };

  const stopSlideshow = () => {
    if (intervalRef.current) clearInterval(intervalRef.current);
    setCurrentImage(0);
  };

  useEffect(() => {
    return () => stopSlideshow();
  }, []);

  const defaultOptions = {
    reverse: false,
    max: 12,
    perspective: 1000,
    scale: 1.02,
    speed: 1000,
    transition: true,
    axis: null,
    reset: true,
    easing: "cubic-bezier(.03,.98,.52,.99)",
  };

  return (
    <Tilt options={defaultOptions} className="w-full">
      <div
        className="group relative w-full h-[450px] rounded-3xl overflow-hidden shadow-2xl bg-black/40 backdrop-blur-xl border border-white/10 transition-all duration-300 hover:shadow-cyan-500/20 hover:border-white/20"
        onMouseEnter={startSlideshow}
        onMouseLeave={stopSlideshow}
      >
        <AnimatePresence mode="popLayout">
          <motion.div
            key={currentImage}
            initial={{ opacity: 0, scale: 1.05 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.6, ease: 'easeInOut' }}
            className="absolute inset-0 z-0"
          >
            <Image
              src={images[currentImage]}
              alt={name}
              fill
              className="object-cover transition-transform duration-700 group-hover:scale-110"
              sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
            />
          </motion.div>
        </AnimatePresence>

        <div className="absolute inset-0 bg-gradient-to-t from-black/95 via-black/40 to-transparent z-10" />
        
        <div className="absolute bottom-0 left-0 w-full p-6 z-20 flex flex-col gap-2">
          <h3 className="text-2xl font-bold text-white tracking-tight leading-tight line-clamp-2">{name}</h3>
          <p className="text-xl font-medium text-cyan-400">{price}</p>
          
          <div className="flex gap-1 mt-2">
            {images.map((_, i) => (
              <div 
                key={i} 
                className={`h-1.5 rounded-full transition-all duration-300 ${
                  i === currentImage ? 'w-6 bg-cyan-400' : 'w-2 bg-white/30'
                }`}
              />
            ))}
          </div>
        </div>

        {/* Glossy overlay effect */}
        <div className="absolute inset-0 bg-gradient-to-tr from-white/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500 z-30 pointer-events-none" />
      </div>
    </Tilt>
  );
};