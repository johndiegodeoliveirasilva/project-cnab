require 'pagy/extras/array'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 10

Pagy::DEFAULT[:overflow] = :empty_page