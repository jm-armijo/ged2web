require_relative './union_builder'

class TreeNode
    def initialize
        @nodes = []
    end

    def add(node)
        @nodes.push(node)
    end

    def add_from_list(list)
        @nodes.concat(list)
        @nodes.uniq!(&:id)
    end

    def length
        return @nodes.length
    end

    def parents
        parents = []
        persons.each do |person|
            parents.concat(person.parents)
        end
        return parents.uniq(&:id)
    end

    def children
        children = []
        families.each do |family|
            children.concat(family.children)
        end
        return children
    end

    def persons
        persons = []
        @nodes.each do |node|
            if node.respond_to?('persons')
                persons.concat(node.persons)
            else
                persons.push(node)
            end
        end

        return persons.uniq
    end

    def families
        families = []
        persons.each do |person|
            families.concat(person.families)
        end

        return families.uniq
    end

    def siblings
        siblings = []
        persons.each do |person|
            siblings.concat(person.siblings)
        end

        return siblings.uniq
    end

    def unions
        if person?
            unions = @nodes
        elsif family?
            node = @nodes.first
            unions = [node.husband, node, node.wife]
        else
            builder = UnionBuilder.new
            unions = builder.build(@nodes)
        end
        return unions
    end

    def any_person?(person_ids)
        persons.each do |person|
            return true if person_ids.include?(person.id)
        end

        return false
    end

    def any_family?(family_ids)
        families.each do |family|
            return true if family_ids.include?(family.id)
        end

        return false
    end

    def person?
        return @nodes.length == 1 && first.type == 'Person'
    end

    def family?
        return @nodes.length == 1 && first.type == 'Family'
    end

    def dummy?
        return @nodes.length == 1 && first.class.name == 'NullFamily'
    end

    def private?
        return persons.any?(&:private?)
    end

    def <(other)
        return true if other.nil?

        birth1 = persons.first.birth
        birth2 = other.persons.first.birth

        date1 = birth1 == '' ? '' : birth1.date.to_s
        date2 = birth2 == '' ? '' : birth2.date.to_s

        return date1 < date2
    end

private

    def first
        return @nodes.first
    end
end
