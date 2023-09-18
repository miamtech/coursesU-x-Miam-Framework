# 1.2.0
- [FIX] Fix Issue on Meal Planner Filters 

# 1.1.1
- [FIX] Added small UI updates to BPL, Recipe Details
- [FIX] implemented [weak self] to reduce memory leaks
- [FIX] update No Recipes error page & text on Replace Recipes

# 1.1.0

# 1.0.8
- [FIX] Added loader on Replace Recipes page Price
- [FIX] Form on Meal Planner has up to date max number of Recipes

# 1.0.7
- [FIX] Meal Planner Form defaults to all 0 values 
- [FEA] if totalPrice on BasketPreviewLine is 0, users are informed & cannot proceed
- [FIX] CoursesUMyMealEmptyView is public
- [FIX] Loader on BasketPreviewLine items
- [FIX] Recipes on ReplaceRecipePage do not need to reload everytime
- [FEA] Currency symbol on right side for ItemSelector

# 1.0.6
- [FIX] Fix Infinite Loader on BPL
- [FEA] When a user deletes all recipes on the Meal Planner & adds one back, the recipe will be at the place they tapped.
- [FIX] Max number of guests now set to 9, fixes issue where larger number would show first before going to 9.
- [FEA] Added originial version of CoursesUMyMealsEmpty()

# 1.0.5
- [FEA] Input field on Budget resets when user presses it
- [FIX] Added loader on Basket Preview that prevents "price of zero" issue
- [FIX] Swapped Form Icons
- [FIX] Currency symbol now trailing

# 1.0.4
- [FEA] Added loader on Basket Preview Line for both delete & change guest count
- [FEA] Added onClose to Recap
- [FEA] Added Recipe Details page to Basket Preview Line

# 1.0.3
- [FIX] RecipeDetailsStepsViewTemplate now working as expected, uses new Binding activeStep 
- [FIX] RecipeDetails showing proper price per meal, added isForMealPlanner Bool to RecipeDetailsViewTemplate
- [FIX] Replace Screen now has proper loading & shows when no results returned
- [FIX] Entire placeholder button tappable

# 1.0.2
- [FIX] Prevented Form not working due to back-end change
- [FIX] Prevented App crashing when number of expected results greater than actual
- [FEA] Added proper recipe price to Recipe Details
- [FIX] Updated logo sizes, moved footer to prevent users rushing through Basket Previews

# 1.0.1
- [FIX] Added Missing Like Button Images
- [FEA] Added Pull To Refresh on Meal Planner
- [FEA] Added Recipe Details Templating 
- [FEA] Added Update number of Guests on BasketPreview

# 1.0.0
- Initial Commit


