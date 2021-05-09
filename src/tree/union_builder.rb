class UnionBuilder
    def build(nodes)
        families = nodes.clone
        unions = [families[0].husband]

        while families.length.positive?
            push_families_into_unions(unions, families)
            unshift_families_into_unions(unions, families)
        end

        return unions
    end

private

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
