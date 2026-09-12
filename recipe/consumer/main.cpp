#include <crc32c/crc32c.h>
#include <cstdint>
#include <iostream>
#include <string>
int main() {
    const std::string data = "123456789";
    const auto* bytes = reinterpret_cast<const uint8_t*>(data.data());
    const uint32_t expected = 0xe3069283;
    if (crc32c::Crc32c(data) != expected || crc32c_value(bytes, 9) != expected)
        return 1;
    for (size_t split = 0; split <= data.size(); ++split) {
        if (crc32c::Extend(crc32c::Extend(0, bytes, split), bytes + split,
                           data.size() - split) != expected) return 2;
        if (crc32c_extend(crc32c_value(bytes, split), bytes + split,
                          data.size() - split) != expected) return 3;
    }
    if (crc32c::Crc32c("", 0) != 0) return 4;
    std::cout << "C and C++ CRC32C known-answer and incremental checks passed\n";
}
