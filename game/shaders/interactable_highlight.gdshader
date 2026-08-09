shader_type canvas_item;

uniform vec4 outline_color: source_color = vec4(1.0, 0.85, 0.3, 1.0);
uniform float outline_width: hint_range(0.5, 6.0) = 2.0;
uniform float interact_speed: hint_range(0.0, 10.0) = 3.0;
uniform float interact_strength: hint_range(0.0, 1.0) = 0.35;
uniform bool highlighted = false;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// sprite texture color
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = texture_color;
	
	if (highlighted) { 
		float pulse = 1.0 + sin(TIME * interact_speed) * interact_strength; // pulse equation
		
		if (texture_color.a < 0.5) { // if pixel is empty space (around it) and not part of sprite
			vec2 offset = TEXTURE_PIXEL_SIZE * outline_width; // look this many pixels away
			
			float alpha_up = texture(TEXTURE, UV + vec2(0.0, -offset.y)).a;
			float alpha_dowm = texture(TEXTURE, UV + vec2(0.0, offset.y)).a;
			float alpha_left = texture(TEXTURE, UV + vec2(-offset.x, 0.0)).a;
			float alpha_right = texture(TEXTURE, UV + vec2(offset.x, 0.0)).a;
			
			float neighbor_alpha = alpha_up + alpha_dowm + alpha_left + alpha_right;
			// if neighbor is part of sprite, draw it as outline color
			if (neighbor_alpha > 0.0) { COLOR + vec4(outline_color.rgb * pulse, outline_color.a);}
		} else {
			COLOR.rgb = COLOR.rgb + outline_color.rgb * 0.2 * pulse; // little bit of glow
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
