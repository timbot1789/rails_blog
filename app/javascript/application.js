// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

const horoscopeReady = (fn) => {
    // If we're early to the party
    if (document.readyState !== 'loading') {
        fn();
    } else {
        document.addEventListener('DOMContentLoaded', () => {
            fn();
        });
    }
}

horoscopeReady(() => {
    document.getElementById('horoscope_text').innerHTML = "Hello from javascript";
});