require_relative 'group'
require_relative 'tree'

class TreeBuilder
    def initialize
        @groups = []
        @visited = []
        @tree = nil
    end

    def make(ged)
        @tree = Tree.new
        generate_groups(ged)
        process_group(@groups[0])

        puts @tree.generations.length
        return @tree
    end

private

    def generate_groups(ged)
        ged.persons.each_value do |person|
            group = find_group_with_person(person) || create_group(person)
            group.add(person)
        end
    end

    def process_group(group, generation = 0)
        return if @visited.include?(group) || group.nil?

        @visited.push(group)
        @tree.add_group_to_generation(generation, group)
        add_groups_to_generation(generation + 1, find_groups_with_persons(group.children))
        add_groups_to_generation(generation - 1, find_groups_with_persons(group.parents))
    end

    def add_groups_to_generation(generation, groups)
        groups.uniq.each do |group|
            process_group(group, generation)
        end
    end

    def find_groups_with_persons(persons)
        return persons.map { |person| find_group_with_person(person) }
    end

    def find_group_with_person(person)
        @groups.find do |group|
            group.person?(person)
        end
    end

    def create_group(person)
        group = person.families.length.zero? ? PersonGroup.new : FamilyGroup.new
        @groups.push(group)
        return group
    end
end