#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ifstream file("text");
    if (!file) {
        std::cerr << "Unable to open file: token\n";
        return 1;
    }

    std::string encoded;
    std::getline(file, encoded);  // Read the entire line
    file.close();

    std::string decoded;
    for (size_t i = 0; i < encoded.length(); i++) {
        decoded += static_cast<char>(static_cast<int>(encoded[i]) - static_cast<int>(i));
    }

    std::cout << decoded << std::endl;

    return 0;
}