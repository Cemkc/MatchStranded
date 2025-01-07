#pragma once

#include <glm/glm.hpp>

namespace Ovis
{
	struct Vertex
	{
		glm::vec3 Position;
		glm::vec4 Color;
		glm::vec2 TexCoords;
		int TexId;
	};
}