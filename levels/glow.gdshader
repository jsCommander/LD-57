shader_type canvas_item;

uniform vec4 glow_color: source_color = vec4(0.2, 0.6, 0.3, 1.0);
uniform float glow_power: hint_range(0.0, 8.0, 0.1) = 2.0;
uniform float glow_radius: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float glow_shift: hint_range(1.0, 10.0, 1.0) = 1.0;
uniform float blink_speed: hint_range(0.0, 10.0, 0.1) = 3.0;
uniform float blink_min: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float blink_max: hint_range(0.0, 1.0, 0.1) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 glow = vec4(0.0);
	float count = 0.0;

	for (float x = -glow_radius; x <= glow_radius; x += 1.0) {
		for (float y = -glow_radius; y <= glow_radius; y += 1.0) {
			vec2 offset = vec2(x, y) * glow_shift * TEXTURE_PIXEL_SIZE;
			vec4 pixel = texture(TEXTURE, UV + offset);
			glow += pixel * glow_color;
			count += 1.0;
		}
	}

	glow *= glow_power / count;
	vec4 pixel = texture(TEXTURE, UV);

	// Добавляем мигание
	float blink_factor = (sin(TIME * blink_speed) + 1.0) * 0.5; // Преобразуем sin из [-1,1] в [0,1]
	float current_glow = mix(blink_min, blink_max, blink_factor);

	COLOR = mix(pixel, glow, glow.a * current_glow);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
