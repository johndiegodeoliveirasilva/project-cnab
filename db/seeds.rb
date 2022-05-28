# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Create KindTransactions"
KindTransaction.create(
  [
    {kind: 1, description: "Débito", nature: "entrada", signal: "+"},
    {kind: 2, description: "Boleto", nature: "saida", signal: "-"},
    {kind: 3, description: "Financiamento", nature: "saida", signal: "-"},
    {kind: 4, description: "Crédito", nature: "entrada", signal: "+"},
    {kind: 5, description: "Recebimento Empréstimo	", nature: "entrada", signal: "+"},
    {kind: 6, description: "Vendas", nature: "entrada", signal: "+"},
    {kind: 7, description: "Recebimento TED", nature: "entrada", signal: "+"},
    {kind: 8, description: "Recebimento DOC", nature: "entrada", signal: "+"},
    {kind: 9, description: "Aluguel", nature: "saida", signal: "-"}
]
)
puts "Done!"