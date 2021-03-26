#pragma once
#include <string>
#include <memory>
#include <stdexcept>
#include <map>
#include <cassert>

template<typename Resource, typename Identifier>
class ResourceHolder
{
public:
	void load(Identifier, const std::string&);
	template<typename Parameter>
	void load(Identifier, const std::string&, Parameter);

	void unload(Identifier);
	void unloadAll();

	Resource& get(Identifier);
	const Resource& get(Identifier) const;

private:
	std::map<Identifier, std::unique_ptr<Resource>> m_ResourceMap;
};


template<typename Resource, typename Identifier>
inline void ResourceHolder<Resource, Identifier>::load(Identifier ID, const std::string& filename)
{
	std::unique_ptr<Resource> resource(new Resource);

	if (!resource->loadFromFile(filename))
	{
		throw std::runtime_error("ResourceHolder::load - Failed to load " + filename);
	}

	auto inserted = m_ResourceMap.insert(std::make_pair(ID, std::move(resource)));

	assert(inserted.second);
}

template<typename Resource, typename Identifier>
template<typename Parameter>
inline void ResourceHolder<Resource, Identifier>::load(Identifier ID, const std::string& filename, Parameter secondParam)
{
	std::unique_ptr<Resource> resource(new Resource);

	if (!resource->loadFromFile(filename, secondParam))
	{
		throw std::runtime_error("ResourceHolder::load - Failed to load " + filename);
	}

	auto inserted = m_ResourceMap.insert(std::make_pair(ID, std::move(resource)));

	assert(inserted.second);
}

template<typename Resource, typename Identifier>
inline void ResourceHolder<Resource, Identifier>::unload(Identifier ID)
{
	auto found = m_ResourceMap.find(ID);
	found->second.reset();
	m_ResourceMap.erase(found);
}


template<typename Resource, typename Identifier>
inline void ResourceHolder<Resource, Identifier>::unloadAll()
{
	m_ResourceMap.clear();
}

template<typename Resource, typename Identifier>
inline Resource& ResourceHolder<Resource, Identifier>::get(Identifier ID)
{
	auto found = m_ResourceMap.find(ID);
	assert(found != m_ResourceMap.end());

	return *found->second;
}

template<typename Resource, typename Identifier>
inline const Resource& ResourceHolder<Resource, Identifier>::get(Identifier ID) const
{
	const auto found = m_ResourceMap.find(ID);
	assert(found != m_ResourceMap.cend());

	return *found->second;
}

