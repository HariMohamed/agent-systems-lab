# Motion (React) Reference Guide

**Source**: Authored reference based on official documentation for `motion/react` (formerly Framer Motion).

## Overview
Motion is a production-ready motion library for React. It uses a hybrid engine: the native Web Animations API (WAAPI) for hardware-accelerated properties (like `opacity` and `transform`), and a JavaScript fallback for other properties.

## Core API
- **Import Path**: Always use `motion/react`, NOT `framer-motion` (deprecated for modern React).
  ```jsx
  import { motion } from "motion/react";
  ```

- **Motion Components**: Use `motion.div`, `motion.span`, etc., just like HTML elements but with animation props.
  ```jsx
  <motion.div
    initial={{ opacity: 0, y: 20 }}
    animate={{ opacity: 1, y: 0 }}
    transition={{ duration: 0.5 }}
  />
  ```

- **AnimatePresence**: Used for animating components out of the React tree.
  ```jsx
  <AnimatePresence>
    {isVisible && (
      <motion.div
        exit={{ opacity: 0 }}
      />
    )}
  </AnimatePresence>
  ```

## Current Best Practices

1. **CSS First vs. Motion**: Use standard CSS transitions for simple hover states or toggle effects. Use Motion when state, layout changes, complex sequencing, gestures, or scroll animations justify it.

2. **Accessibility (Reduced Motion)**: Motion automatically respects the system's "reduce motion" preference for hardware-accelerated animations. To explicitly read the preference for complex JS-driven animations:
  ```jsx
  import { useReducedMotion } from "motion/react";
  
  function MyComponent() {
    const shouldReduceMotion = useReducedMotion();
    return <motion.div animate={{ x: shouldReduceMotion ? 0 : 100 }} />;
  }
  ```

3. **Layout Animations**: Use the `layout` prop to automatically animate between layout changes (e.g., list reordering, flexbox changes).
  ```jsx
  <motion.div layout />
  ```

## Gestures and Scroll
- **Gestures**: Built-in props for interactions like `whileHover`, `whileTap`, `whileDrag`, and `whileInView`.
- **Scroll**: Advanced scroll-linked animations via `useScroll` and `useTransform`.
