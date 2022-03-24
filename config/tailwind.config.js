const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require("tailwindcss/colors")

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
      aspectRatio: {
        '3/2': '3 / 2',
      },
      screens: {
        'hover-hover': {'raw': '(hover: hover)'},
      }
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      white: colors.white,
      black: colors.black,
      gray: colors.gray,
      'cream': '#FFEFE4',
      'terracotta': {
        DEFAULT: '#8D2B00',
        'light': '#E3C2B3',
      },
      'mandarin': {
        DEFAULT: '#B55119',
        'light': '#E9D4C9',
      },
      'shale': {
        DEFAULT: '#545E45',
        'light': '#C7CBC1',
      },
      'forest': {
        DEFAULT: '#1F2D16',
        'light': '#B3B9AF',
      },
      'water': {
        DEFAULT: '#197DB5',
        'light': '#BFCFD8',
      },
      'spotify': '#1DB954',
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
