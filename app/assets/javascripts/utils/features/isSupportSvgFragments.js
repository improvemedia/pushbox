export default function() {
  const userAgent = navigator.userAgent;

  return [
    !userAgent.match(/Version\/[\d\.]+.*Safari/),
    !userAgent.match(/iPad|iPhone|iPod/),
    !window.MSStream,
  ].every((cond) => cond);
}