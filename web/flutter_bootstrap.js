{{flutter_js}}
{{flutter_build_config}}

// Use the renderer files bundled by Flutter instead of downloading CanvasKit
// from the Google CDN. This lets the app start when that CDN is unavailable.
_flutter.loader.load({
  config: {
    canvasKitBaseUrl: 'canvaskit/',
  },
});
