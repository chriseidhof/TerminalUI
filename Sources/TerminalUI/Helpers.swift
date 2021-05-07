extension Array {
    // expectes the array to be sorted by groupId
    func group<A: Equatable>(by groupId: (Element) -> A) -> [[Element]] {
        guard !isEmpty else { return [] }
        var groups: [[Element]] = []
        var currentGroup: [Element] = [self[0]]
        for element in dropFirst() {
            if groupId(currentGroup[0]) == groupId(element) {
                currentGroup.append(element)
            } else {
                groups.append(currentGroup)
                currentGroup = [element]
            }
        }
        groups.append(currentGroup)
        return groups
    }
}
