require "open-uri"

images = [
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/PDP_Paloma_Midnight1_1200x_a2bc90d7-e9b5-4ef4-ba75-caff4d5ec40a_1198x1800.jpg?v=1620655672',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/PDP_BikeShort_Midnight3_1200x_04fd676a-29e7-460d-b0d4-23e6612e0ae3_1198x1800.jpg?v=1607139590',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/PDP_BikeShort_Midnight2_1200x_bd86356f-bca5-4ed8-93ca-f3c9d1d93277_1198x1800.jpg?v=1607139590',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/purabra-merlot-1_1024x1024-2_658x985.jpg?v=1603149189',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/3_1200x_c162eb50-85e5-4b49-9f3b-5e82094beb8c_1200x1800.jpg?v=1593021795',
	]

puts "Creating Users"
	george = User.create!(
							email: 'george@gmail.com',
							password: 'secret',
							first_name: "George",
							last_name: "Kettle",
							phone: "+61403978505",
							admin: true)
puts "Finished creating Users"


puts "Creating Categories"
	categories = [
		{
			name: 'Luteal phase',
			description: "The Luteal phase is all about slowing down and connecting with your body. These workouts are designed for the second half of your menstrual cycle, where it’s important to be mindful of the current changes happening in your body. Often we feel low energy during this time, for all natural reasons. It’s important to acknowledge this for an optimal workout."
		},
		{
			name: 'Folicular phase',
			description: "These workouts will push you and make you sweat (AKA glow). They are purposely filled with dynamic movements and are specifically designed for the first half of your menstrual cycle. Over this time you will feel your energy rise (Hooray!). Which means more energy for high intensity workouts. You've got this girl!"
		},
		{
			name: 'Fundamentals',
			description: "Not sure where to start? Don’t worry, we have you covered with Fundamentals. Start your fitness journey with a collection of workouts to help you learn the fundamentals of pilates and strength training movements. After just 5 workouts, you’ll be ready to transition to our Folicular and Luteal phase workouts."
		},
		{
			name: 'Stretch',
			description: "These workouts are specifically designed to keep your muscles flexible, strong, and healthy. Stretching helps us to feel light and free of pain. But also to reduce lactic acid build up and muscle soreness after workouts. Meet me on the mat and let's stretch it out!"
		}
	]
	categories.map! { |cat| Category.create!(cat) }

	categories.each_with_index do |category, index|
		img_index = images.length % (index + 1)
		new_category_photo_url = images[img_index]
		new_category_photo = URI.open(new_category_photo_url)
		category.photo.attach(io: new_category_photo, filename: "#{category.name.downcase}.jpeg", content_type: 'image/jpeg')
	end
puts "Finished creating Categories"

puts "Creating Instructors"
	emma = Instructor.create!(first_name: 'Emma', last_name: 'Lyons', bio: 'The face & founder of ALIGN. Emma is your wild, excited, overly honest and entirely dedicated trainer. Wi
	th over 9 years of experience specialising in Group Fitness, Circuit, HIIT, Mat, Barre and Reformer Pilates Training.')
	emma_photo_url = 'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/Always_high27_Navyslate5_1440x.progressive_8ffb9e00-6dfe-43ac-9aca-944a62c78f29_1350x1800.jpg?v=1637632257'
	emma_photo = URI.open(emma_photo_url)
	emma.photo.attach(io: emma_photo, filename: "#{emma.first_name.downcase}_#{emma.last_name.downcase}.jpeg", content_type: 'image/jpeg')
puts "Finished creating Instructors"

puts "Creating Workouts"
	workouts = [
		{
			name: 'HIIT session',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('Luteal phase'),
			instructor: emma,
			intensity: 'high',
			mins: 22,
			membership: false
		},
		{
			name: 'Yin yoga',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('Folicular phase'),
			instructor: emma,
			intensity: 'low',
			mins: 35,
			membership: false
		},
		{
			name: 'Booty workout',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('Luteal phase'),
			instructor: emma,
			intensity: 'high',
			mins: 32,
		},
		{
			name: 'Abs be burnin',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('Foundations'),
			instructor: emma,
			intensity: 'high',
			mins: 43,
		},
		{
			name: 'Stretchy',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('Stretch'),
			instructor: emma,
			intensity: 'low',
			mins: 22,
		},
	]

	workouts.each_with_index do |workout, index|
		new_workout = Workout.create!(workout)
		img_index = images.length % (index + 1)
		new_workout_photo_url = images[img_index]
		new_workout_photo = URI.open(new_workout_photo_url)
		new_workout.photo.attach(io: new_workout_photo, filename: "#{new_workout.name.downcase}.jpeg", content_type: 'image/jpeg')
	end
puts "Finished creating Workouts"