// this is a shim file for dev
// in production, this file should dynamically return values to be set on process.env
window.process = window.process || {};
window.process.env = {};
