
import ProductCard from '@/components/ProductCard';
import { supabase } from '@/lib/supabase';

export const revalidate = 60;

type Product = {
  id: string;
  name: string;
  images: string[];
  price: number;
};

const CategoryPage = async ({ params }: { params: { slug: string } }) => {
  const { data: products, error } = await supabase
    .from('products')
    .select('*')
    .eq('category_slug', params.slug);

  if (error) {
    console.error('Error fetching products:', error);
    return <div>Error loading products.</div>;
  }

  if (!products || products.length === 0) {
    return <div>No products found in this category.</div>;
  }

  return (
    <div className="container mx-auto">
      <h1 className="text-3xl font-bold my-8">Categoría: {params.slug}</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {products.map((product: Product) => (
          <ProductCard key={product.id} {...product} />
        ))}
      </div>
    </div>
  );
};

export default CategoryPage;
