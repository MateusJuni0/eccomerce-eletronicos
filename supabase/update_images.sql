UPDATE ecommerce.products SET images = ARRAY[
  'https://picsum.photos/seed/' || slug || '-1/800/600',
  'https://picsum.photos/seed/' || slug || '-2/800/600',
  'https://picsum.photos/seed/' || slug || '-3/800/600'
];