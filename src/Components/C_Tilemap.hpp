#ifndef C_TILEMAP_HPP
#define C_TILEMAP_HPP

#include "../Tilemaps/SFMLOrthogonalLayer.hpp"
#include <vector>
#include <memory>

struct C_Tilemap
{
    C_Tilemap() = default;
    explicit C_Tilemap(const std::string &path) : m_MapPath(path)
    {
    }

    std::string m_MapPath{};
    std::vector<std::unique_ptr<MapLayer>> m_TileLayers;
    std::vector<std::unique_ptr<tmx::ObjectGroup>> m_ObjectLayers;
};


#endif //C_TILEMAP_HPP