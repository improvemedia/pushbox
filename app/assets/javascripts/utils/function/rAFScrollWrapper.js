export default function rAFScrollWrapper(callback, threshold) {
  let ticked  = true;
  let lastTimestamp = Date.now();

  return () => {
    if (!ticked) {
      return;
    }

    if (threshold && Date.now() - lastTimestamp < threshold) {
      return;
    }

    window.requestAnimationFrame(() => {
      ticked = true;
      lastTimestamp = Date.now();

      callback();
    });

    ticked = false;
  }
}