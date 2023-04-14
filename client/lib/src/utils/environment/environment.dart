import 'package:envied/envied.dart';
part 'environment.g.dart';

@Envied(path: '.env.development')
abstract class Environment {
  @EnviedField(varName: 'PUBLIC_KEY', obfuscate: true)
  static final flPublicKey = _Environment.flPublicKey;
}
