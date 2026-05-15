// Service Worker for PWA support - Generated for GitHub Pages deployment
const CACHE_NAME = 'portfolio-v1';
const urlsToCache = [
  '/portfolioApp/',
  '/portfolioApp/index.html',
  '/portfolioApp/manifest.json',
  '/portfolioApp/favicon.png',
  '/portfolioApp/flutter_bootstrap.js',
  '/portfolioApp/assets/images/profile.png',

  '/portfolioApp/assets/images/feature_graphic.svg',
  '/portfolioApp/assets/icons/icon.png',
  '/portfolioApp/assets/icons/icon.svg',
  '/portfolioApp/assets/icons/gt_logo.svg',
  '/portfolioApp/assets/animations/loading_animation.json',
  '/portfolioApp/assets/animations/error_animation.json',
  '/portfolioApp/assets/resume/Govind_Tank_Resume.html',
  '/portfolioApp/icons/Icon-192.png',
  '/portfolioApp/icons/Icon-512.png',
  '/portfolioApp/icons/Icon-maskable-192.png',
  '/portfolioApp/icons/Icon-maskable-512.png',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('Opened cache');
      return cache.addAll(urlsToCache);
    }),
  );
  self.skipWaiting();
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      if (response) {
        return response;
      }
      return fetch(event.request).then((response) => {
        if (!response || response.status !== 200 || response.type !== 'basic') {
          return response;
        }
        const responseToCache = response.clone();
        caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, responseToCache);
        });
        return response;
      });
    }),
  );
});

self.addEventListener('activate', (event) => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        }),
      );
    }),
  );
});
