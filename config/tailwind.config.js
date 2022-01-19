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
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      white: colors.white,
      black: colors.black,
      gray: colors.gray,
      'cream': '#FFEFE4',
      'terracotta': '#8D2B00',
      'mandarin': '#B55119',
      'carrot': '#BE6731',
      'earth': '#76704C',
      'shale': '#545E45',
      'forest': '#1F2D16',
      'water': '#197DB5',
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
