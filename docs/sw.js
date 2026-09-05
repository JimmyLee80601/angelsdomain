const CACHE_NAME = 'angels-domain-v2';
const ASSETS = [
  '/',
  '/index.html',
  '/scenes.json',
  '/manifest.json',
  '/images/angel_portrait.svg',
  '/images/seraphina_portrait.svg',
  '/images/corridor_deep_passage.jpg',
  '/images/corridor_misty_approach.jpg',
  '/images/corridor_the_doors.jpg',
  '/images/chamber_firelit.jpg',
  '/images/chamber_supernatural.jpg',
  '/images/fireplace_intimate.jpg',
];

self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS))
  );
  self.skipWaiting();
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', (e) => {
  e.respondWith(
    caches.match(e.request).then((cached) => cached || fetch(e.request))
  );
});
