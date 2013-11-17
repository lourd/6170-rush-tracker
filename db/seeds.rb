# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
fraternities = Fraternity.create([{ name: 'Devfrat' }])
brothers = Brother.create!(firstname: 'Admin', lastname: 'User', email: 'random-engineers@mit.edu', password: 'adminpass', password_confirmation: 'adminpass', is_verified: true, is_admin: true)
