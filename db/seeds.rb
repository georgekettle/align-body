require "open-uri"

puts "Creating Users"
	george = User.create!(email: 'george@gmail.com', password: 'secret')
puts "Finished creating Users"


puts "Creating Categories"
	categories = [
		{
			name: 'HIIT',
			color: '#FFCFBB',
			description: 'Our effective & high energy class. Incorporating different methods of body weight & light equipment based training. ALIGN. HIIT is a seamless 30 minute HIIT class focused on optimal burn & cardiovascular endurance. We use a variety of timing methods such as Tabata, EMOM, etc. ALIGN. HIIT is suitable for all levels and can be done in the comfort of your living room.'
		},
		{
			name: 'Flow',
			color: '#FFEDB8',
			description: 'Is our most known signature styled class. It is 30 minutes of shaping and toning. An engaging, high energy & low intensity class. FLOW incorporates minimal bouncing, for maximum burning. Focusing on the stabilising muscles, FLOW combines the benefits of Barre and Mat pilates. FLOW is suitable for all levels and has its own Pre & Postnatal safe library.'
		},
		{
			name: 'Flex',
			color: '#CAE5FF',
			description: 'Our signature style Yin Class. To embrace both masculine & female energy. A full body relaxation class that serves one intention - to release, stretch & let go. Focusing on relieving areas of discomfort and tension throughout the body. Our FLEX class explore different intentions & stretches so you can gain the most from your practice. FLEX is suitable for all levels.'
		}
	]
	categories.each { |cat| Category.create!(cat) }
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
			category: Category.find_by_name('HIIT'),
			instructor: emma,
			difficulty: 'hard',
			mins: 22,
		},
		{
			name: 'Yin yoga',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('Flex'),
			instructor: emma,
			difficulty: 'medium',
			mins: 35,
		},
		{
			name: 'Booty workout',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('HIIT'),
			instructor: emma,
			difficulty: 'easy',
			mins: 32,
		},
		{
			name: 'Abs be burnin',
			video_url: 'https://player.vimeo.com/video/209288527',
			category: Category.find_by_name('Flow'),
			instructor: emma,
			difficulty: 'medium',
			mins: 43,
		},
	]

	workout_images = [
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/PDP_Paloma_Midnight1_1200x_a2bc90d7-e9b5-4ef4-ba75-caff4d5ec40a_1198x1800.jpg?v=1620655672',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/PDP_BikeShort_Midnight3_1200x_04fd676a-29e7-460d-b0d4-23e6612e0ae3_1198x1800.jpg?v=1607139590',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/PDP_BikeShort_Midnight2_1200x_bd86356f-bca5-4ed8-93ca-f3c9d1d93277_1198x1800.jpg?v=1607139590',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/purabra-merlot-1_1024x1024-2_658x985.jpg?v=1603149189',
		'https://cdn.shopify.com/s/files/1/0114/5995/2698/products/3_1200x_c162eb50-85e5-4b49-9f3b-5e82094beb8c_1200x1800.jpg?v=1593021795',
	]

	workouts.each_with_index do |workout, index|
		new_workout = Workout.create!(workout)
		img_index = workout_images.length % (index + 1)
		new_workout_photo_url = workout_images[img_index]
		new_workout_photo = URI.open(new_workout_photo_url)
		new_workout.photo.attach(io: new_workout_photo, filename: "#{new_workout.name.downcase}.jpeg", content_type: 'image/jpeg')
	end
puts "Finished creating Workouts"