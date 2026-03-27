"use client";

import React from "react";
import { motion } from "framer-motion";
import Link from "next/link";
import { cn } from "@/lib/utils";

const navVariants = {
  hidden: { y: -100, opacity: 0 },
  visible: { y: 0, opacity: 1, transition: { type: "spring", stiffness: 120, damping: 20 } },
};

export function PremiumNav() {
  return (
    <motion.nav 
      variants={navVariants}
      initial="hidden"
      animate="visible"
      className={cn(
        "fixed top-0 left-0 right-0 z-50",
        "px-8 py-4",
        "bg-background/80 backdrop-blur-lg border-b border-border"
      )}
    >
      <div className="container mx-auto flex justify-between items-center">
        <Link href="/" className="text-2xl font-bold text-primary tracking-wider">
          NEXUS
        </Link>
        {/* Placeholder for mega-menu trigger */}
        <div className="text-foreground">Categories</div>
      </div>
    </motion.nav>
  );
}
