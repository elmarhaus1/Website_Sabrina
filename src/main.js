import de from './i18n/de.json';
import fr from './i18n/fr.json';

const translations = { de, fr };

// ─── State ───
let currentLang = localStorage.getItem('lang') || 'de';

// ─── DOM Ready ───
document.addEventListener('DOMContentLoaded', () => {
  initCurtain();
  initI18n();
  initNavigation();
  initLightbox();
  initScrollReveal();
  initModal();
  initParallax();
});

// ─── Curtain ───
function initCurtain() {
  const curtain = document.getElementById('curtain');
  setTimeout(() => {
    curtain.classList.add('is-open');
  }, 800);
  setTimeout(() => {
    curtain.style.display = 'none';
  }, 2600);
}

// ─── i18n ───
function initI18n() {
  applyLanguage(currentLang);

  const langToggle = document.getElementById('langToggle');
  const langLabel = document.getElementById('langLabel');

  langToggle.addEventListener('click', () => {
    currentLang = currentLang === 'de' ? 'fr' : 'de';
    localStorage.setItem('lang', currentLang);
    applyLanguage(currentLang);
  });
}

function applyLanguage(lang) {
  const t = translations[lang];
  const langLabel = document.getElementById('langLabel');
  langLabel.textContent = lang === 'de' ? 'FR' : 'DE';
  document.documentElement.lang = lang;

  document.querySelectorAll('[data-i18n]').forEach(el => {
    const key = el.getAttribute('data-i18n');
    if (t[key]) {
      el.textContent = t[key];
    }
  });

  // Swap vita PDF link based on language
  const vitaLink = document.querySelector('.vita__download');
  if (vitaLink) {
    if (lang === 'fr') {
      vitaLink.href = '/assets/pdfs/Sabrina_Haus_VITA_2020_FR.pdf';
    } else {
      vitaLink.href = '/assets/pdfs/Sabrina_Haus_VITA_2022.pdf';
    }
  }

  // Update page title
  document.title = lang === 'de'
    ? 'Sabrina Haus – Schauspielerin · Comédienne'
    : 'Sabrina Haus – Comédienne · Schauspielerin';
}

// ─── Navigation ───
function initNavigation() {
  const nav = document.getElementById('nav');
  const toggle = document.getElementById('navToggle');
  const links = document.getElementById('navLinks');

  // Scroll effect
  let ticking = false;
  window.addEventListener('scroll', () => {
    if (!ticking) {
      requestAnimationFrame(() => {
        nav.classList.toggle('is-scrolled', window.scrollY > 80);
        ticking = false;
      });
      ticking = true;
    }
  });

  // Mobile toggle
  toggle.addEventListener('click', () => {
    toggle.classList.toggle('is-active');
    links.classList.toggle('is-open');
  });

  // Close mobile nav on link click
  links.querySelectorAll('.nav__link').forEach(link => {
    link.addEventListener('click', () => {
      toggle.classList.remove('is-active');
      links.classList.remove('is-open');
    });
  });

  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', e => {
      const target = document.querySelector(anchor.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });
}

// ─── Lightbox ───
function initLightbox() {
  const lightbox = document.getElementById('lightbox');
  const lightboxImg = document.getElementById('lightboxImg');
  const lightboxCaption = document.getElementById('lightboxCaption');
  const items = document.querySelectorAll('.gallery__item');
  let currentIndex = 0;

  const images = Array.from(items).map(item => ({
    src: item.querySelector('img').src,
    caption: item.querySelector('figcaption').textContent.trim(),
  }));

  function showImage(index) {
    currentIndex = (index + images.length) % images.length;
    lightboxImg.src = images[currentIndex].src;
    lightboxCaption.textContent = images[currentIndex].caption;
  }

  items.forEach((item, i) => {
    item.addEventListener('click', () => {
      showImage(i);
      lightbox.classList.add('is-active');
      lightbox.setAttribute('aria-hidden', 'false');
      document.body.style.overflow = 'hidden';
    });
  });

  function closeLightbox() {
    lightbox.classList.remove('is-active');
    lightbox.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = '';
  }

  lightbox.querySelector('.lightbox__close').addEventListener('click', closeLightbox);
  lightbox.querySelector('.lightbox__prev').addEventListener('click', () => showImage(currentIndex - 1));
  lightbox.querySelector('.lightbox__next').addEventListener('click', () => showImage(currentIndex + 1));

  lightbox.addEventListener('click', e => {
    if (e.target === lightbox || e.target.classList.contains('lightbox__content')) {
      closeLightbox();
    }
  });

  document.addEventListener('keydown', e => {
    if (!lightbox.classList.contains('is-active')) return;
    if (e.key === 'Escape') closeLightbox();
    if (e.key === 'ArrowLeft') showImage(currentIndex - 1);
    if (e.key === 'ArrowRight') showImage(currentIndex + 1);
  });
}

// ─── Scroll Reveal ───
function initScrollReveal() {
  const sections = document.querySelectorAll('.section');
  sections.forEach(s => s.classList.add('reveal'));

  const observer = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1, rootMargin: '0px 0px -50px 0px' }
  );

  sections.forEach(s => observer.observe(s));
}

// ─── Parallax ───
function initParallax() {
  const heroImage = document.querySelector('.hero__image-wrapper');
  if (!heroImage) return;

  let ticking = false;
  window.addEventListener('scroll', () => {
    if (!ticking) {
      requestAnimationFrame(() => {
        const scrollY = window.scrollY;
        const rate = scrollY * 0.15;
        heroImage.style.transform = `translateY(${rate}px)`;
        ticking = false;
      });
      ticking = true;
    }
  });
}

// ─── Modals (Impressum & Datenschutz) ───
function initModal() {
  const modals = [
    { modal: document.getElementById('impressumModal'), anchor: '#impressum' },
    { modal: document.getElementById('privacyModal'), anchor: '#datenschutz' },
  ];

  function openModal(modal) {
    modal.classList.add('is-active');
    modal.setAttribute('aria-hidden', 'false');
    document.body.style.overflow = 'hidden';
  }

  function closeModal(modal) {
    modal.classList.remove('is-active');
    modal.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = '';
  }

  function closeAll() {
    modals.forEach(({ modal }) => closeModal(modal));
  }

  modals.forEach(({ modal, anchor }) => {
    if (!modal) return;

    document.querySelectorAll(`a[href="${anchor}"]`).forEach(link => {
      link.addEventListener('click', e => {
        e.preventDefault();
        closeAll();
        openModal(modal);
      });
    });

    modal.querySelector('.modal__close').addEventListener('click', () => closeModal(modal));
    modal.querySelector('.modal__backdrop').addEventListener('click', () => closeModal(modal));
  });

  document.addEventListener('keydown', e => {
    if (e.key === 'Escape') closeAll();
  });
}
