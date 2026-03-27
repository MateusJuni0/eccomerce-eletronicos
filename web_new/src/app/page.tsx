import { HeroCanvas } from '@/components/3d/HeroCanvas';
import { BentoCard, BentoGrid } from '@/components/ui/BentoGrid';
import {-
  ArrowRightIcon,
  CircleIcon,
  GlobeIcon,
  InputIcon,
  LayoutIcon,
  MessageSquareIcon,
  RowsIcon,
  SettingsIcon,
  TableIcon,
} from 'lucide-react';

const features = [
  {
    Icon: CircleIcon,
    name: 'Integrations',
    description: 'Connect to your favorite services and tools.',
    href: '/',
    cta: 'Learn more',
    background: <img className="absolute -right-20 -top-20 opacity-60" />,
  },
  {
    Icon: MessageSquareIcon,
    name: 'Messages',
    description: 'Send and receive messages from your users.',
    href: '/',
    cta: 'Learn more',
    background: <img className="absolute -right-20 -top-20 opacity-60" />,
  },
  {
    Icon: TableIcon,
    name: 'Tables',
    description: 'Manage your data in a familiar spreadsheet-like interface.',
    href: '/',
    cta: 'Learn more',
    background: <img className="absolute -right-20 -top-20 opacity-60" />,
  },
  {
    Icon: InputIcon,
    name: 'Forms',
    description: 'Create and manage forms to collect data from your users.',
    href: '/',
    cta: 'Learn more',
    background: <img className="absolute -right-20 -top-20 opacity-60" />,
  },
  {
    Icon: GlobeIcon,
    name: 'Domains',
    description: 'Manage your domains and DNS settings.',
    href: '/',
    cta: 'Learn more',
    background: <img className="absolute -right-20 -top-20 opacity-60" />,
  },
];

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="relative w-full h-screen">
        <HeroCanvas />
      </div>

      <BentoGrid>
        {features.map((feature, idx) => (
          <BentoCard key={idx} {...feature} />
        ))}
      </BentoGrid>
    </main>
  );
}
