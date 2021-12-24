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
workouts.each { |workout| Workout.create!(workout) }
puts "Finished creating Workouts"