// Определяем тип шейдера как canvas_item для работы с 2D графикой
shader_type canvas_item;

// Экранная текстура
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Цвет фона (белый по умолчанию)
uniform vec4 u_bgColor = vec4(1.0, 1.0, 1.0, 1.0);
// Сила смешивания фонового цвета (0.4 = 40% по умолчанию)
uniform float u_bgColorFactor = 0.4;
// Цвет паттерна (черный по умолчанию)
uniform vec4 u_patternColor = vec4(0.0, 0.0, 0.0, 1.0);

// Пороговые значения для разных уровней интенсивности
// Порог для самого яркого уровня (75%)
uniform float u_threshold1 = 0.75;
// Порог для второго уровня (50%)
uniform float u_threshold2 = 0.50;
// Порог для третьего уровня (25%)
uniform float u_threshold3 = 0.25;
// Порог для четвертого уровня (5%)
uniform float u_threshold4 = 0.05;

// Масштабирование фоновой текстуры
uniform vec2 u_bgTiling = vec2(1.0, 1.0);
// Масштабирование текстуры паттерна
uniform vec2 u_patternTiling = vec2(1.0, 1.0);

// Текстуры для фона и паттерна
uniform sampler2D u_bgTexture;
uniform sampler2D u_patternTexture;

// Константы для математических вычислений
// Квадратный корень из 2
const float C2_SQRT2 = 0.707106781;
// Матрица поворота на 45 градусов
const mat2 ROT_45 = mat2(vec2(C2_SQRT2, -C2_SQRT2), vec2(C2_SQRT2, C2_SQRT2));
// Белый цвет для смешивания
const vec4 COLOR_WHITE = vec4(1.0, 1.0, 1.0, 1.0);

// Функция для вычисления яркости цвета
// Использует стандартные коэффициенты для RGB
float getIntensity(vec3 color)
{
	return 0.299*color.r + 0.587*color.g + 0.114*color.b;
}

// Функция для получения цвета паттерна в зависимости от интенсивности
vec4 getPatternColor(vec2 uv, float intensity)
{
	// Создаем разные UV координаты для паттерна с разными трансформациями
	vec2 patternUV1 = vec2(-uv.x, uv.y) * u_patternTiling;  // Отражение по X
	vec2 patternUV2 = uv * u_patternTiling;                  // Оригинальные координаты
	vec2 patternUV3 = ROT_45*(uv + vec2(0.2358, 0.9123)) * u_patternTiling;  // Поворот на 45°
	vec2 patternUV4 = (vec2(uv.x, -uv.y) + vec2(0.4123, 0.7218)) * u_patternTiling;  // Отражение по Y + смещение

	// Получаем цвета для каждого варианта паттерна
	vec4 pCol1 = texture(u_patternTexture, patternUV1);
	vec4 pCol2 = texture(u_patternTexture, patternUV2);
	vec4 pCol3 = texture(u_patternTexture, patternUV3);
	vec4 pCol4 = texture(u_patternTexture, patternUV4);

	// Возвращаем разные варианты паттерна в зависимости от интенсивности
	if(intensity > u_threshold1)
		return vec4(1.0, 1.0, 1.0, 1.0);  // Полностью белый
	if(intensity > u_threshold2)
		return mix(pCol1, COLOR_WHITE, 0.5);  // Смешивание с белым
	if(intensity > u_threshold3)
		return mix(pCol1*pCol2, COLOR_WHITE, 0.3);  // Умножение двух паттернов
	if(intensity > u_threshold4)
		return mix(pCol1*pCol2*pCol3, COLOR_WHITE, 0.1);  // Умножение трех паттернов
	return pCol1*pCol2*pCol3*pCol4*0.8;  // Умножение всех паттернов
}

// Основная функция фрагментного шейдера
void fragment()
{
	// Получаем исходный цвет из экранной текстуры
	vec4 origColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	// Вычисляем интенсивность исходного цвета
	float intensity = getIntensity(origColor.rgb);
	// Смешиваем фоновую текстуру с цветом фона
	vec4 bgColor = mix(texture(u_bgTexture, UV*u_bgTiling), u_bgColor, u_bgColorFactor);
	// Получаем цвет паттерна на основе интенсивности
	vec4 patternColor = getPatternColor(UV, intensity);
	// Финальное смешивание цвета паттерна с фоном
	vec4 color = mix(u_patternColor, bgColor, getIntensity(patternColor.rgb));
	// Устанавливаем результирующий цвет
	COLOR = color;
}