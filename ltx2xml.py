import re
processed_string = open('Original LaTeX Food File.tex').read()

# Recipes
match_string = re.compile(ur'\\recipe{([a-zA-Z0-9_ ]*)}')
substitution_string = ur'<Recipe Title="\1" Meals="2">'
processed_string = re.sub(match_string, substitution_string, processed_string)

match_string = re.compile(ur'\\quick{([a-zA-Z0-9_ ]*)}')
substitution_string = ur'<Recipe Title="\1" Meals="1">'
processed_string = re.sub(match_string, substitution_string, processed_string)

# Stage
match_string = re.compile(ur'\\st')
substitution_string = u"<Stage>"
processed_string = re.sub(match_string, substitution_string, processed_string)

# Ingredients
ingredients = {'ve': 'Vegetable', 'ch': 'Check', 'da': 'Dairy', 'gr': 'Grocery', 'me': 'Meat', 'wa': 'Water'};
for key, value in ingredients.iteritems():
    match_string = re.compile(ur'\\' + key + '{([a-zA-Z0-9_. ]*)}{([a-zA-Z0-9_ ]*)}{([a-zA-Z0-9_ ]*)}{([a-zA-Z0-9_ ]*)}')
    substitution_string = ur'<' + value + ' Quantity="\\1" Unit="\\2" Type="\\3" Process="\\4"/>'
    processed_string = re.sub(match_string, substitution_string, processed_string)

#Remove Process="" and Unit=""


# Utensils
utensils = {'cass': 'casserole', 'bowl': 'bowl', 'pan': 'pan', 'wok': 'wok'};
for key, value in utensils.iteritems():
    match_string = re.compile(ur'\\' + key)
    substitution_string = u'<Utensil Name=\"' + value + '\" />'
    processed_string = re.sub(match_string, substitution_string, processed_string )

# replace \pasta{spaghetti} with <Staple Name="spaghetti"/>

outfile = open('Original LaTeX Food File.xml', 'w')

outfile.write(processed_string)
outfile.close()
