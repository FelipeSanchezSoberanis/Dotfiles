import unidecode

def cleanText(text):
	for character in '.,':
		text = text.replace(character, '')

	text = unidecode.unidecode(text)

	return text

