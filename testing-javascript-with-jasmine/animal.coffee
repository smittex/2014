require = window.require

describe 'The Animal Model', ->
	Animal = require('models/animal')

	a = group = null

	beforeEach ->
		a = new Animal(species:'equine', name:'one for the money', age:'3 years', gender:'male', breed:'ariabian', headCount:1, color:'purple', dob:new Date(), remarks:'remark') 
		group = new Animal(name:"swine2", isGroup:true, age:2, headCount:3, gender:'male', breed:'fat', species:'Bovine')

	afterEach ->
		Animal.deleteAll()
	
	it 'will save a valid animal', ->
		animalCount = Animal.count()
		a.save(ajax:false)
		expect(Animal.count()).toBe(animalCount + 1)
	
	it 'will not save Animal that does not validate', ->
		b = new Animal(name:"sample")
		b.save(ajax:false)
		expect(Animal.count()).toBe(0)
	
	it 'will save a valid group', ->
		animalCount = Animal.count()
		group.save(ajax:false)
		expect(Animal.all().length).toBe(animalCount + 1)
	
	it 'will not save a group that does not validate', ->
		group2 = new Animal(name:"swine2", isGroup: true)
		group2.save(ajax:false)
		expect(Animal.all().length).toBe(0)
		
	it 'will expect idTypes and ids to corespond if they are present', ->
		a.idTypes = 'one, two'
		a.ids = 'asdfasdfa'
		a.save(ajax:false)
		expect(Animal.count()).toBe(0)
		a.ids = 'asdf, another'
		a.save(ajax:false)
		expect(Animal.count()).toBe(1)
	
	# much much more error prone to validate this for group situations
	it 'will not expect idTypes and ids to corespond if they are present for groups', ->
		group.idTypes = 'one, two'
		group.ids = 'asdfasdfa'
		group.save(ajax:false)
		expect(Animal.count()).toBe(1)
		
	it 'will expect no one id in an animals ids to be more than 255 characters', ->
		a.idTypes = 'one'
		a.ids = 'asdfasdfa asdf asdf a98df a9s8df 9asdf j9asdf j98asdf j98df j9asdjf 9a8sdf j98asdjf 98sdjf 98asd fj98asdj f89asdjf 89adsf 8a9sdjf 9djf 9asdf j89asdf jasdkf0 asdf 98asjdf 98asdjf 98asdjf 98adjf 98asdjf 98asdjf 98adsjf 98adf j98asdjf 89asdjf 98ajsdf 98asdf j89aj f98ajf 98ajsdf 98asdfj 98adjf98adfj9a8sdjf98ajdf98asdj 98sdfj 98asdfj 98asdjf 98asdfj'
		a.save(ajax:false)
		expect(Animal.count()).toBe(0)
		a.ids = 'not quite so long...'
		a.save(ajax:false)
		expect(Animal.count()).toBe(1)
		
	it 'will expect no one id in a groups ids to be more than 255 characters', ->
		group.idTypes = 'one'
		group.ids = "[['short', 3, 'asdfasdfa asdf asdf a98df a9s8df 9asdf j9asdf j98asdf j98df j9asdjf 9a8sdf j98asdjf 98sdjf 98asd fj98asdj f89asdjf 89adsf 8a9sdjf 9djf 9asdf j89asdf jasdkf0 asdf 98asjdf 98asdjf 98asdjf 98adjf 98asdjf 98asdjf 98adsjf 98adf j98asdjf 89asdjf 98ajsdf 98asdf j89aj f98ajf 98ajsdf 98asdfj 98adjf98adfj9a8sdjf98ajdf98asdj 98sdfj 98asdfj 98asdjf 98asdfj']]"
		group.save(ajax:false)
		expect(Animal.count()).toBe(0)
		group.ids = "[['short', 3, 'asdfasdfa asdf asdf a98df']]"
		group.save(ajax:false)
		expect(Animal.count()).toBe(1)
