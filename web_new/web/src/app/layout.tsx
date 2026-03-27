import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { cn } from "@/lib/utils";
import { PremiumNav } from "@/components/premium-nav";
import { PremiumFooter } from "@/components/premium-footer";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Nexus E-Commerce",
  description: "Cinematic Portal",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body className={cn("min-h-screen bg-background font-sans antialiased", inter.className)}>
        <PremiumNav />
        <main className="relative flex flex-col min-h-screen">
            {children}
        </main>
        <PremiumFooter />
      </body>
    </html>
  );
}
