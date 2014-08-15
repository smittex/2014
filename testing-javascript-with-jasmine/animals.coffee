require = window.require

describe 'Animals Controller', ->
	Animals  = require('controllers/animals')
	Animal   = require('models/animal')
	Ecvi     = require('models/ecvi')
	Fixtures = specs('fixtures')
	
	# define test subjects
	controller = animal = animal2 = ecvi = null

	appDom = '<div id="animals"></div>'
	
	beforeEach ->
		Fixtures.createTestData()
		ecvi       = Fixtures.ecvi
		animal     = Fixtures.animal
		animal2    = Fixtures.createUnsavedAnimal()
		controller = new Animals({el: appDom, ecvi:ecvi, isGroup: false })
		spyOn(window,'alert').andReturn(true)

		runs ->
			spyOn(controller, 'list').andCallThrough()
			spyOn(Animal, 'fetch').andCallFake ->
				animal.save(ajax:false)
				Animal.trigger('refresh')

			controller.add(animal.id)
		waitsFor ->
			controller.list.wasCalled
		runs ->
			# fake ajax call (we need to do this because esign uses non spine ajax)
			Fixtures.jqXHR.resolve(animal)
	
	afterEach ->
		Fixtures.deleteTestData()
		$("ul.ui-autocomplete").remove()

	it 'can initialize', ->
		expect(Animal.count()).toBe(2)
		expect(controller).toBeTruthy()
	
	it 'can create animal listing', ->
		expect(Animal.fetch).toHaveBeenCalledWith({ id:animal.id })
		expect(controller.ecvi.animals.length).toBe(1)
		expect(controller.el.find('.animalItem').length).toBe(2)
	
	it 'can trigger autocomplete event', ->
		runs ->
			# something to look out for is that the autocomplete plugin seems to be stored
			# under a different key in the data() attributes when new versions of jquery
			# are released. Do a console.log controller.animalAuto.data() to see them all)
			spyOn(controller.animalAuto.data("ui-autocomplete"), "source").andCallFake (request, response)->
				return response([{ label: "swine2", id: 33 }])
			controller.animalAuto.val('swine')
			controller.animalAuto.keydown()

		waitsFor (-> $("ul.ui-autocomplete > li").size() > 0) , "autocomplete list not visible"

		runs ->
			item = $("ul.ui-autocomplete > li:contains('swine2')")
			expect(item.length).toBe(1)
			Animal.fetch.andCallFake ->
				animal2.save()
				Animal.trigger('refresh')
			item.mouseover()
			item.trigger("click")

		waitsFor ->
			controller.list.wasCalled

		runs ->
			expect(Animal.fetch).toHaveBeenCalledWith({ id: 33 })
			expect(controller.list).toHaveBeenCalled()
		
	it 'can render a form for editing chosen animal', ->
		#need to animals in list so borrow code from add to list test first
		runs ->
			Animal.fetch.andCallFake ->
				animal2.save()
				Animal.trigger('refresh')
			controller.add(animal2.id)

		waitsFor 'list to be called', ->
			controller.list.wasCalled

		runs ->
			expect(Animal.fetch).toHaveBeenCalledWith({ id:animal2.id })
			expect(controller.el.find('.animalItem').length).toBe(2)
			expect(controller.ecvi.animals.length).toBe(2)
			# chose the first animal and trigger edit
			spyOn(controller, 'editItem').andCallFake ->
				controller.renderEditView(animal, true)
			spyOn(controller, 'edit').andCallThrough()
			spyOn(controller, 'editById').andCallThrough()
			spyOn(controller, 'renderEditView').andCallThrough()
			controller.el.find('a.animalEdit:first').trigger('click')
			expect(controller.edit).toHaveBeenCalled()
			expect(controller.editById).toHaveBeenCalledWith(animal.id.toString())
			expect(controller.editItem).toHaveBeenCalled()
			#console.log controller
			expect(controller.item.__proto__).toBeTruthy()

		waitsFor 'edit view to be rendered ', ->
			controller.renderEditView.wasCalled

		runs ->
			form = controller.el.find(":input")
			expect(form.filter("[name=name]").val()).toBe(animal.name)

	it 'can remove an animal from the list via remove link', ->
		runs ->
			expect(Animal.findTypeAnimal().length).toBe(1)
			expect(controller.ecvi.animals.length).toBe(1)
			spyOn(controller, 'remove').andCallThrough()
			spyOn(window, 'confirm').andReturn(true)
			controller.el.find('a.removeAnimalTrigger').trigger('click')

		waitsFor ->
			controller.list.wasCalled

		runs ->
			expect(controller.remove).toHaveBeenCalled()
			expect(window.confirm).toHaveBeenCalled()
			expect(controller.ecvi.animals.length).toBe(0)

