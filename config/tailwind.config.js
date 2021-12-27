const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Magnet', ...defaultTheme.fontFamily.sans],
        serif: ['Value Serif', ...defaultTheme.fontFamily.serif],
        display: ['Magnet Display', 'Magnet', ...defaultTheme.fontFamily.sans]
      },
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      'white': '#ffffff',
      'black': '#000',
      'cream': '#FFEFE4',
      'terracotta': '#8D2B00',
      'mandarin': '#B55119',
      'carrot': '#BE6731',
      'earth': '#76704C',
      'shale': '#545E45',
      'forrest': '#545E45',
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
