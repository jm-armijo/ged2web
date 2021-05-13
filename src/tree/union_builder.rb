class UnionBuilder
    def build(nodes, sorted_nodes)
        families = nodes.clone
        unions = [families[0].husband]

        while families.length.positive?
            push_families_into_unions(unions, families)
            unshift_families_into_unions(unions, families)
        end

        return sorted?(unions, sorted_nodes) ? unions : unions.reverse
    end

private

    def sorted?(unions, sorted_nodes)
        id_first_family = unions[1].id
        id_last_family = unions[-2].id

        index_first_family = sorted_nodes.find_index { |node| node.id == id_first_family } || 0
        index_last_family  = sorted_nodes.find_index { |node| node.id == id_last_family } || sorted_nodes.length

        return index_first_family < index_last_family
    end

    def push_families_into_unions(unions, families)
        last_person = unions.last
        family = find_and_pop_family(families, last_person)
        return if family.nil?

        unions.push(family)
        unions.push(family.other_spouse(last_person))
    end

    def unshift_families_into_unions(unions, families)
        first_person = unions.first
        family = find_and_pop_family(families, first_person)
        return if family.nil?

        unions.unshift(family)
        unions.unshift(family.other_spouse(first_person))
    end

    def find_and_pop_family(families, spouse)
        index = families.find_index { |family| family.spouse?(spouse) }
        return nil if index.nil?

        family = families[index]
        families.delete_at(index)
        return family
    end
end
