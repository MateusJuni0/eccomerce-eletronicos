/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      { hostname: 'www.info-computer.com' },
      { hostname: 'picsum.photos' },
      { hostname: 'images.unsplash.com' }
    ]
  }
};

export default nextConfig;