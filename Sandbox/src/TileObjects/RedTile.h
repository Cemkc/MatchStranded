#pragma once

#include "Ovis.h"
#include "Block.h"

using namespace Ovis;

class RedTile : public Block
{
public:
	RedTile(){
		m_Type = TileObjectType::Red;
	}

	virtual int GetCategoryFlags() const override { return Block::GetCategoryFlags(); }
};