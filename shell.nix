{ pkgs, ... }:
pkgs.mkShell {
	packages = with pkgs; [
		uv
		kaggle

		rocmPackages.rocm-runtime
		rocmPackages.rocm-smi
		rocmPackages.rocminfo
	];

	env = {
		UV_PYTHON = "${pkgs.python312}/bin/python";
		
		HSA_OVERRIDE_GFX_VERSION="10.3.0";

		LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
			stdenv.cc.cc.lib
			zstd

			# rocmPackages.rocm-core
			# rocmPackages.rocm-runtime
			# rocmPackages.clr
			# rocmPackages.hiprand
			# rocmPackages.rocfft
			# rocmPackages.hipfft
		]);
	};

	shellHook = ''
	export PATH=$PWD/.venv/bin:$PATH
	'';
}
