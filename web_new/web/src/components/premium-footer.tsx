"use client";

import React from "react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

export function PremiumFooter() {
  return (
    <motion.footer 
      initial={{ opacity: 0 }}
      animate={{ opacity: 1, transition: { delay: 0.5, duration: 1 } }}
      className={cn(
        "w-full py-6 mt-24",
        "border-t border-border"
      )}
    >
      <div className="container mx-auto text-center text-sm text-gray-400">
        <p>&copy; {new Date().getFullYear()} NEXUS by CMTecnologia. All rights reserved.</p>
      </div>
    </motion.footer>
  );
}
