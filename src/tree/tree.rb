require_relative 'group'

class Tree
    def initialize(ged)
        @groups = []

        @ged = ged
        @persons = @ged.records.filter { |_k, v| v.tag == 'INDI' }
    end

    def groups
        @persons.each_value do |person|
            group = find_group_with_person(person) || create_group(person)
            group.add(person)
        end
    end

private

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
