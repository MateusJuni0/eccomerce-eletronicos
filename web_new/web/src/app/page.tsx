import { supabase } from '@/lib/supabase';
import { HomeHero } from '@/components/home/HomeHero';
import { HomeCategories } from '@/components/home/HomeCategories';
import { HomeFeatured } from '@/components/home/HomeFeatured';

export const revalidate = 60; // ISR, atualiza a cada 60s

export default async function HomePage() {
    // Buscar produtos em destaque do Supabase (vamos pegar os 4 primeiros ou mais caros)
    const { data: featuredProducts } = await supabase
        .from('products')
        .select('*')
        .order('price_cents', { ascending: false }) // Os mais caros/premium
        .limit(4);

    return (
        <main className="min-h-screen bg-[#020617] text-white selection:bg-cyan-500/30 font-sans">
            <HomeHero />
            <HomeCategories />
            <HomeFeatured products={featuredProducts || []} />
        </main>
    );
}